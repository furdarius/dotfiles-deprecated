# Ansible
export PATH=$PATH:/opt/ansible/bin
export PYTHONPATH=$PYTHONPATH:/opt/ansible/lib
export MANPATH=$MANPATH:/opt/ansible/docs/man

# Golang
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/Documents/golang
export PATH=$PATH:$GOPATH/bin

export TERM=xterm-256color

SSH_ENV="$HOME/.ssh/env"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
