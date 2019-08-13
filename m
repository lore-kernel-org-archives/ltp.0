From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Aug 2019 15:13:03 +0200
Subject: [LTP] [PATCH v2 1/2] clock_getres01: drop case which is passing
 NULL res parameter
In-Reply-To: <6520324.6276380.1565699170263.JavaMail.zimbra@redhat.com>
References: <ee463189a82212a10c1ac06229dc0a418e18305b.1565361031.git.jstancek@redhat.com>
 <20190813121202.GB16005@rei.lan>
 <6520324.6276380.1565699170263.JavaMail.zimbra@redhat.com>
Message-ID: <20190813131302.GA18888@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Shouldn't we keep the REALTIME clock here and pass the &res here
> > instead?
> 
> Test already has that as 1st entry in tcase array:
>    {"REALTIME", CLOCK_REALTIME, &res, 0, 0},

Missed that, sorry.

> > Can we please print which variant we are about to test from the test
> > setup() as well?
> 
> Sure, I'll add that.

Consider the patch acked then.

-- 
Cyril Hrubis
chrubis@suse.cz
