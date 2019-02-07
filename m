From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 7 Feb 2019 13:52:42 +0100
Subject: [LTP] [PATCH] ustat: Fix EFAULT in 32bit compatability mode
In-Reply-To: <20190207101835.641-1-rpalethorpe@suse.com>
References: <20190202001727.13269-1-smuckle@google.com>
 <20190207101835.641-1-rpalethorpe@suse.com>
Message-ID: <20190207125242.GA20833@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

> This test fails with -m32 on Intel because the user land dev_num is too
> large.

Thanks for the fix, merged.


Kind regards,
Petr
