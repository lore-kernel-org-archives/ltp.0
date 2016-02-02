From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Feb 2016 18:02:54 +0100
Subject: [LTP] [PATCH V2 22/32] include sys/types.h
In-Reply-To: <1452302060-103643-22-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
 <1452302060-103643-22-git-send-email-raj.khem@gmail.com>
Message-ID: <20160202170254.GM19199@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Fixes
> 
> error: unknown type name 'uint'

Just use unsigned int instead.

-- 
Cyril Hrubis
chrubis@suse.cz
