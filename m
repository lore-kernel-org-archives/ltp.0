From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 31 Aug 2016 15:51:48 +0200
Subject: [LTP] [PATCH] tst_virt: Make use of systemd-detect-virt if
	available
In-Reply-To: <1783998347.724638.1471526149366.JavaMail.zimbra@redhat.com>
References: <20160818123809.GA26650@rei.suse.cz>
 <1783998347.724638.1471526149366.JavaMail.zimbra@redhat.com>
Message-ID: <20160831135147.GA7346@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> We could also add a function that tries "virt-what", to increase our chances.
> Anyway, I think it's good idea to not rely just on /proc/cpuinfo.

Pushed with your Acked-by.

-- 
Cyril Hrubis
chrubis@suse.cz
