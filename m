From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Mar 2020 15:07:39 +0100
Subject: [LTP] Subject: [PATCH] Update legacy codes in ltp_tpci.c
In-Reply-To: <87mu8smyab.wl-chenli@uniontech.com>
References: <87mu8smyab.wl-chenli@uniontech.com>
Message-ID: <20200313140739.GA21248@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,


> The kernel api used in ltp_tpci.c is too old and connot pass compile
> after 3.12.
Merged as obviously correct.
I added git commit references.

BTW whole pci is not used atm.
We should decide for versions we want to support and then update kernel
versions, which are now wrongly set to 2.6:

REQ_VERSION_MAJOR := 2
REQ_VERSION_PATCH := 6

This waits for project to define which kernel versions we support.
We had some discussion about it in the past, I just cannot find it,
so I'll probably send a new mail about it.

Kind regards,
Petr
