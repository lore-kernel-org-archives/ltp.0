From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 4 Oct 2018 14:59:52 +0200
Subject: [LTP] [PATCH 1/2] testcases: netns: Check TUN support enabled
In-Reply-To: <20180802141251.1571-1-mylene.josserand@bootlin.com>
References: <20180802141251.1571-1-mylene.josserand@bootlin.com>
Message-ID: <20181004125952.GA32169@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Mylène,

> In case TUN support is not enabled, the test will fail while
> performing the "ip" command with following error:
>    open: No such file or directory
>    netns_netlink    1  TBROK  :  netns_netlink.c:143: system() failed

> As the system() call is not setting errno, we are not able to know
> if the error is produced by a mis-configuration or not.

> Because of that, this commit adds a check during the setup function to see
> if the device "/dev/net/tun" is available or not. It is the file
> that "ip tuntap add mode tap" command is looking for (and fails with
> the "open" error).

> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> ---
>  testcases/kernel/containers/netns/netns_netlink.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

> diff --git a/testcases/kernel/containers/netns/netns_netlink.c b/testcases/kernel/containers/netns/netns_netlink.c
> index 47e8235d6..077ec5dab 100644
> --- a/testcases/kernel/containers/netns/netns_netlink.c
> +++ b/testcases/kernel/containers/netns/netns_netlink.c
> @@ -57,6 +57,15 @@ static void cleanup(void)

>  static void setup(void)
>  {
> +	/* Check that the TUN support is available */
> +	int netfd = open("/dev/net/tun", O_RDWR);
> +	if (netfd == -1) {
> +		if (errno == ENODEV || errno == ENOENT)
> +			tst_brkm(TCONF, NULL, "TUN support is missing?");
> +
> +		tst_brkm(TBROK | TERRNO, NULL, "opening /dev/net/tun failed");
> +	}

Can you please implement your patch via .needs_drivers (recently contributed by
Alexey Kodanev)?


Kind regards,
Petr
