From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Mar 2017 17:49:47 +0100
Subject: [LTP] [PATCH] ltp: detect the test id automatically
In-Reply-To: <20170314072529.24567-1-liwang@redhat.com>
References: <20170314072529.24567-1-liwang@redhat.com>
Message-ID: <20170314164947.GA9183@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void get_tid(char *argv[])
> +{
> +	char *p;
> +
> +	tst_test->tid = (p = strrchr(argv[0], '/')) ? p+1 : argv[0];
> +}

This is interesting idea, but this oneliner is ugly and does not work
when you execute the testcase by full path, i.e.
/opt/ltp/testcases/bin/foo01 would end up with
opt/ltp/testcases/bin/foo01 in tid.

And I wonder if we can avoid runtime detection, which is always tricky.
Maybe we can just do:

struct tst_test test = {
	.id = __FILE__,
};

And strip the .c suffix in the test library if present. That way we
would avoid this kind of copy&paste errors.

-- 
Cyril Hrubis
chrubis@suse.cz
