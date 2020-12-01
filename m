From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 1 Dec 2020 13:32:42 +0300
Subject: [LTP] Make FTP test compatible with Busybox and Dropbear.
In-Reply-To: <20201130203324.613c1b08@kmaincent-XPS-13-7390>
References: <20201130203324.613c1b08@kmaincent-XPS-13-7390>
Message-ID: <faa8352f-7ec0-4fa6-8d5d-4fd4c1366f9f@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 30.11.2020 22:33, K?ry Maincent wrote:
> Hello,
> 

Hi Kory,

> I am working with LTP on an embedded board.
> I would like to notice the rhost_run command does not work with Dropbear ssh
> client. I am trying to understand how tst_net work but I am a bit struggling
> with it. What is the usage of TST_USE_NETNS, and the purpose of netspace (it
> seems to be used to configure a virtual interface)?
> My aim was to make FTP test work with Dropbear and Busybox. If someone could
> point me out how to do it.
> 

ssh is used for two host setup only, if you are running on a single
machine, it's not used at all. Instead tst_rhost_run() runs the command
in the different namespace (ltp_ns), and it is the default setup. Also, by
default, tst_net.sh creates veth pair to connect to ltp_ns and run network
tests over it.

Moreover such setup can be replaced via RHOST environment variable (two
host setup + using ssh) and ssh becomes the management link, or custom
network namespace via LTP_NETNS var. Test network parameters replaced
via IPV4{6}_LHOST/IPV4{6}_RHOST vars.


> Regards,
> 
> K?ry
> 
> 

