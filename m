From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Aug 2019 11:55:21 +0200
Subject: [LTP] [PATCH] tst_res: Print errno number in addition to error
 name
In-Reply-To: <20190819133618.7538-1-rpalethorpe@suse.com>
References: <20190819133618.7538-1-rpalethorpe@suse.com>
Message-ID: <20190820095521.GA22253@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> It appears we are atleast missing ENOTSUPP (524) which is probably returned by
> create_timer for some alarm clocks on none x86 arches. This isn't entirely
> clear, but what is clear is that it would help to know what the error number
> is without using strace.

Can we please also patch the lib/errnos.h so that the ENOTSUPP is
included there as well?

-- 
Cyril Hrubis
chrubis@suse.cz
