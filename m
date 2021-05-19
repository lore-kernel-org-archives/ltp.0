From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 19 May 2021 17:10:05 +0200
Subject: [LTP] [RFC PATCH 6/6] API: Check exported symbols
In-Reply-To: <YKT+XzCGrf4bxq7G@yuki>
References: <20210517163029.22974-1-rpalethorpe@suse.com>
 <20210517163029.22974-7-rpalethorpe@suse.com>
 <YKN4SZcHP9GAGRH4@pevik> <87im3gl5yx.fsf@suse.de>
 <YKPVwoRiJKLqneN3@pevik> <87cztnks0n.fsf@suse.de>
 <YKT+XzCGrf4bxq7G@yuki>
Message-ID: <YKUqTa2AFbdwjFSy@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril, Richie,

> Hi!
> > OK, I guess you can just shorten the regex by substituing "[lL]io_\w+"
> > for all the lio stuff. Or filter by file instead.

> Another option would be moving the tlibio.c and random_range.c to
> libs/libltpobsolete/ and adding LTPLIBS flags for the few tests that
> actually use that code.

Thank you both for tips, both ways would work for me.

Kind regards,
Petr
