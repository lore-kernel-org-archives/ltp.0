From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 30 Aug 2021 18:56:44 +0200
Subject: [LTP] [PATCH 2/2] Add CHECK_NOFLAGS and checkpatch.pl to 'make
 check'
In-Reply-To: <YSzeJvfWZja/oKnR@yuki>
References: <20210827095210.23602-1-rpalethorpe@suse.com>
 <20210827095210.23602-2-rpalethorpe@suse.com>
 <YSjXX6NWbDzu5X9m@pevik> <YSzeJvfWZja/oKnR@yuki>
Message-ID: <YS0NzOjXwPXlP8F/@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

> Well I do see this to be mainly targetting development so that everyone
> can do 'make check' before submitting. So I would like to get this
> merged ASAP and we can try to make it work with CI later on.

Sure! Running make check for particular test substitute the need to do anything
with the patchset.

Kind regards,
Petr
