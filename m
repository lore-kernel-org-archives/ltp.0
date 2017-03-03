From: Hoang Nguyen <the_hoang0709@yahoo.com>
Date: Fri, 3 Mar 2017 01:01:18 +0000 (UTC)
Subject: [LTP] [PATCH] min_free_kbytes : Check panic_on_oom before
 running
In-Reply-To: <20170302161057.GA8152@rei.lan>
References: <20170206132419.11060-1-the_hoang0709@yahoo.com>
 <20170302161057.GA8152@rei.lan>
Message-ID: <1006507850.879579.1488502878749@mail.yahoo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Cyril,
Thanks. I was thought it's one line (same as some other lines in this file eg. 109), so I tried to put them similiarBut agreed, I also prefer curly braces when coding :D
I will send new patch, with moving it to setup() also.
Thanks for your review
Best regards,
Hoang

      From: Cyril Hrubis <chrubis@suse.cz>
 To: the_hoang0709@yahoo.com 
Cc: ltp@lists.linux.it
 Sent: Thursday, 2 March 2017, 23:10
 Subject: Re: [LTP] [PATCH] min_free_kbytes : Check panic_on_oom before running
   
Hi!
> diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
> index cb00f40..8b6dc1c 100644
> --- a/testcases/kernel/mem/tunable/min_free_kbytes.c
> +++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
> @@ -71,6 +71,9 @@ int main(int argc, char *argv[])
>  
>      tst_parse_opts(argc, argv, NULL, NULL);
>  
> +    if (get_sys_tune("panic_on_oom"))
> +        tst_brkm(TCONF, NULL,
> +            "panic_on_oom is set, disable it to run these testcases");

This check should be put into the test setup() and LKML coding style
prefers curly braces around multiline statemets like this.

Otherwise it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz


   
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170303/cf0ad653/attachment.html>
