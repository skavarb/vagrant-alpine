module VagrantPlugins
    module GuestAlpine
        module Cap
            class NFSClient
                def self.nfs_client_install(machine)
                    comm = machine.communicate
                    comm.sudo <<-EOS.gsub(/^\s+\|\s?/, '')
                        | echo "updating repository indices"
                        | apk update
                        | if [ $? -ne 0 ]; then
                        |     exit 1
                        | fi
                        |
                        | echo "installing nfs-utils"
                        | apk add --upgrade nfs-utils
                        | if [ $? -ne 0 ]; then
                        |     exit 1
                        | fi
                        |
                        | echo "installing rpc.statd"
                        | rc-update add rpc.statd
                        | if [ $? -ne 0 ]; then
                        |     exit 1
                        | fi
                        |
                        | echo "starting rpcbind service"
                        | rc-update add rpcbind
                        | rc-service rpcbind start
                        | if [ $? -ne 0 ]; then
                        |     exit 1
                        |
                        | fi
                        | echo "starting rpc.statd service"
                        | rc-service rpc.statd start
                        | if [ $? -ne 0 ]; then
                        |     exit 1
                        | fi
                    EOS
                end
            end
        end
    end
end
