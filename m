From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 9 Mar 2016 14:52:57 +0100
Subject: [LTP] Question about perf_event_open/Cap_bounds/su01 test cases
In-Reply-To: <250374796.7297169.1457525313432.JavaMail.zimbra@redhat.com>
References: <AF04265A3FC2B144B9892F621A394E13EA3DB009@tethys>
 <250374796.7297169.1457525313432.JavaMail.zimbra@redhat.com>
Message-ID: <20160309135256.GC28171@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > 4. su01 fail with < /bin/su -l root with correct password ( FAILED ) > [more
> > details, please refer to https://justpaste.it/s329].
> >    a. Could be an test issue?
> 
> Don't have much experience with this test, but it looks like
> it relies on group 'wheel' or 'trusted' to be present, and
> in your case it's not:
>   usermod: group 'trusted' does not exist

Looks to me like the group detection (that user needs to run su) is
completly broken. It check only for redhat and assumes that rest of the
world uses group trusted (which is true for suse but seems to be the
only one among widely used distributions).

And the whole testcases is messy and should be rewritten.

-- 
Cyril Hrubis
chrubis@suse.cz
