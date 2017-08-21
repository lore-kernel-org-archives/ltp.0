From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 21 Aug 2017 14:17:58 +0200
Subject: [LTP] [PATCH 1/1] ltp-pan: Log start of test in kernel log
In-Reply-To: <1495369773.970106.1503317547451.JavaMail.zimbra@redhat.com>
References: <20170821090652.17634-1-pvorel@suse.cz>
 <1495369773.970106.1503317547451.JavaMail.zimbra@redhat.com>
Message-ID: <20170821121758.GA6479@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I know ltp-pan is deprecated, but add kernel stamping can be useful for
> > debugging.
> 
> +1, it proved to be useful. It has also been mentioned couple weeks ago here:
>   https://lists.linux.it/pipermail/ltp/2017-June/004893.html
> 
> As I recall Cyril suggested an option to enable/disable this output,
> but I wouldn't mind if it was always-on.

Maybe we should add an option to turn it off then, but apart from that
I'm for making this change.

-- 
Cyril Hrubis
chrubis@suse.cz
