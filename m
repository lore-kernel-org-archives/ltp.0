From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 5 Jan 2021 12:30:43 +0100
Subject: [LTP] [PATCH] df01.sh: Fix failure when block size < 1024
In-Reply-To: <20201221113449.30656-1-radoslav.kolev@suse.com>
References: <20201221113449.30656-1-radoslav.kolev@suse.com>
Message-ID: <X/RN4xt92HwVfDBE@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Radoslav,

> If block size is < 1024 shell integer division will always round down.
> Add 512 (1024/2) to the left side, to cause round up for values >= .5.

Correct, merged.
Thanks!

Kind regards,
Petr
