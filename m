From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Mar 2019 19:50:51 +0100
Subject: [LTP] [PATCH v4 0/3] rt_sigpending02: reuse code from
 sigpending02
In-Reply-To: <20190319184137.8357-1-maennich@google.com>
References: <20190308163832.212631-1-maennich@google.com>
 <20190319184137.8357-1-maennich@google.com>
Message-ID: <20190321185051.GA28973@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Matthias,

> Reusing the code from sigpending for rt_sigpending is a patch I sent in
> earlier. Based on that this adds a new test case for both syscalls to test the
> more common use of sigpending.

> v3 -> v4:
>  - address review comments

> v2 -> v3:
>  - fix comment style
>  - use LTP_ATTRIBUTE_UNUSED

Thanks for your changes, pushed!


Kind regards,
Petr
