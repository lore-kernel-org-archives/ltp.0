From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 22 Dec 2016 00:37:04 +0300
Subject: [LTP] [PATCH 1/1] network: doc: nestore NFS configuration
In-Reply-To: <20161221161812.19969-1-pvorel@suse.cz>
References: <20161221161812.19969-1-pvorel@suse.cz>
Message-ID: <585AF600.2080809@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,
On 21.12.2016 19:18, Petr Vorel wrote:
> Removed in 5f8ca6cf0
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> Cc: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
> Alexey, or was it removed deliberatelly?

Yes, it's done automatically inside network/nfs/nfs_stress/nfs_lib.sh.

Best regards,
Alexey

> ---
>   testcases/network/README.md | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/testcases/network/README.md b/testcases/network/README.md
> index ebaab9956..9399d8aa8 100644
> --- a/testcases/network/README.md
> +++ b/testcases/network/README.md
> @@ -59,6 +59,15 @@ machine <remote_server_name> login root password <remote_root_password>.
>   Otherwise, ftp,rlogin & telnet fails for ‘root’ user & hence needs to be
>   executed using ‘test’ user to get successful results.
>   
> +## NFS setup
> +* In “/etc/exports“, add the following:
> +
> +```
> +/ <local_machine_ip>/255.255.255.0(rw,no_root_squash,sync)
> +```
> +
> +* Then run “exportfs” to get a list of exported file system.
> +
>   ## LTP setup
>   Install LTP testsuite. In case of two hosts configuration, make sure LTP is installed
>   on both client and server machines.

