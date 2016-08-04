From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 4 Aug 2016 03:37:40 -0400 (EDT)
Subject: [LTP] [PATCH] tst_test: Add option parsing helpers.
In-Reply-To: <20160803145925.GA31921@rei.lan>
References: <20160803145925.GA31921@rei.lan>
Message-ID: <261930823.1019774.1470296260665.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Cc: "Jan Stancek" <jstancek@redhat.com>
> Sent: Wednesday, 3 August, 2016 4:59:25 PM
> Subject: [PATCH] tst_test: Add option parsing helpers.
> 
> Add two helpers for parsing integers and floags, these are intended to
> be used in the test setup to parse options from struct tst_option.
> 
> static char *str_threads;
> static int threads;
> ...
> 
> static struct tst_options[] = {
> 	{"t:", &str_threads, "Number of threads"},
> 	...
> 	{NULL, NULL, NULL}
> };
> 
> static void setup(void)
> {
> 	if (tst_parse_int(str_threads, &threads, 1, INT_MAX))
> 		tst_brk(TBROK, "Invalid number of threads '%s'", str_threads);
> 
> 	...
> }
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Reviewed-by: Jan Stancek <jstancek@redhat.com>

Looks good to me.

Regards,
Jan
