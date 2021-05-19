From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 May 2021 14:02:39 +0200
Subject: [LTP] [RFC PATCH 6/6] API: Check exported symbols
In-Reply-To: <87cztnks0n.fsf@suse.de>
References: <20210517163029.22974-1-rpalethorpe@suse.com>
 <20210517163029.22974-7-rpalethorpe@suse.com>
 <YKN4SZcHP9GAGRH4@pevik> <87im3gl5yx.fsf@suse.de>
 <YKPVwoRiJKLqneN3@pevik> <87cztnks0n.fsf@suse.de>
Message-ID: <YKT+XzCGrf4bxq7G@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> OK, I guess you can just shorten the regex by substituing "[lL]io_\w+"
> for all the lio stuff. Or filter by file instead.

Another option would be moving the tlibio.c and random_range.c to
libs/libltpobsolete/ and adding LTPLIBS flags for the few tests that
actually use that code.

-- 
Cyril Hrubis
chrubis@suse.cz
