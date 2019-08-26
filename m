From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 26 Aug 2019 12:05:50 -0400 (EDT)
Subject: [LTP] [PATCH v4 4/4] BPF: Sanity check creating a program
In-Reply-To: <20190826111024.19053-5-chrubis@suse.cz>
References: <20190826111024.19053-1-chrubis@suse.cz>
 <20190826111024.19053-5-chrubis@suse.cz>
Message-ID: <674171843.8194514.1566835550810.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> From: Richard Palethorpe <rpalethorpe@suse.com>
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.min_kver = "3.18",

Small nit, per http://man7.org/linux/man-pages/man2/bpf.2.html it's since 3.19.

Some comments in 2/4, but overall looks good to me.

Acked-by: Jan Stancek <jstancek@redhat.com>
