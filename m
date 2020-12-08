From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 8 Dec 2020 14:54:36 +0100
Subject: [LTP] [PATCH 1/1] syscalls/get_mempolicy01: Rewrite to new API
In-Reply-To: <20201208132814.16497-1-pvorel@suse.cz>
References: <20201208132814.16497-1-pvorel@suse.cz>
Message-ID: <X8+FnIbN1MrOJp4B@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> not sure if invalid address is no longer meaningful (after removing
> fix for ia64 and use NULL).
FYI tst_get_bad_addr(), which would be more portable, didn't work.
Test is designed to use NULL to get EFAULT.

Kind regards,
Petr

