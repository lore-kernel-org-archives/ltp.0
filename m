From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Mar 2016 10:22:26 +0100
Subject: [LTP] Test library API changes
In-Reply-To: <870463953.9758877.1458032315296.JavaMail.zimbra@redhat.com>
References: <20160105111136.GA32659@rei.lan> <20160302144421.GC25763@rei>
 <322891927.4705109.1457010820487.JavaMail.zimbra@redhat.com>
 <20160303140054.GB3055@rei.lan> <20160310165721.GA6142@rei>
 <1172303351.8592023.1457704628083.JavaMail.zimbra@redhat.com>
 <20160314125153.GB600@rei.lan> <20160314160036.GA2511@rei.lan>
 <870463953.9758877.1458032315296.JavaMail.zimbra@redhat.com>
Message-ID: <20160315092226.GA26279@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> That it will only cause signal to be delivered to that thread,
> but handler will still kill entire process.

Ah, right. I tend to forget that part.

> We could use different signal and define a signal handler,
> that would just loop, but that still doesn't guarantee
> when pending signal is delivered. Also threads could mask
> the signal.

We can call a pause() in a loop from the signal handler and check that
the thread is sleeping in the kernel from the main thread. But this is
getting too complicated.

> Then I was thinking about blocking threads using affinity,
> but if test changed priority we could lock ourselves out.
> 
> We do say in style guide, that cleanup can be called at any
> time. Should we leave it up to test author? We had the same
> problem with oldlib, right?

Yes, and technically we have the same problem with the forked processes
as well. When the main process calls tst_brk() the child processes may
still be running. But killing/waiting children in tst_brk() could be
done quite easily.

-- 
Cyril Hrubis
chrubis@suse.cz
