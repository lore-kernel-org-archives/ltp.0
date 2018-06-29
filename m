From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 29 Jun 2018 16:06:14 +0200
Subject: [LTP] [RFC] [PATCH] tst_timer: Add tst_timer_expired_ms()
In-Reply-To: <986909105.29606861.1530215270429.JavaMail.zimbra@redhat.com>
References: <20180628092846.21204-1-chrubis@suse.cz>
 <986909105.29606861.1530215270429.JavaMail.zimbra@redhat.com>
Message-ID: <20180629140614.GB13958@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> 
> ACK

Pushed, thanks.

> I'm thinking if it's worth skipping also tst_timer_check(),
> and adding some like "LTP_TIMER_ANY" that would pick first
> available clockid for you.

For the expiration timer we probably want to try the monotonic timer and
if that fail fall back to the realtime. But I wonder if it's a good idea
to invent our specific timer ids. Maybe it would be better to indroduce
tst_timer_start_any() function instead so that we can do:


static void run(void)
{
	tst_timer_start_any();

	while (!tst_timer_expired_ms(5000)) {
		...
	}
}

-- 
Cyril Hrubis
chrubis@suse.cz
