From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Dec 2015 10:54:18 +0100
Subject: [LTP] {get|set}_thread_area issue on ARM
In-Reply-To: <20151207092503.GA11996@rei.lan>
References: <20151204034711.GA27222@yury-N73SV>
 <20151207092503.GA11996@rei.lan>
Message-ID: <20151207095418.GB11996@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> LTP contains stub syscall definitions for cases when certain
> syscall is not supported by given arch. What is the exact error that
> causes the build failure? I had a look at the test source code and the
> only thing that could be an issue is that there would be duplicate case
> in switch() statement since on aarch64 both __NR_set_thread_area and
> __NR_get_thread_area would be defined to -1 (which means not implemented
> in LTP).

And you allready fixed this problems, thanks :).

-- 
Cyril Hrubis
chrubis@suse.cz
