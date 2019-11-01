From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 1 Nov 2019 08:35:29 +0100
Subject: [LTP] [RFC] Remove {config.h,config.mk,features.mk,}.default ?
Message-ID: <20191101073528.GA22452@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I wonder if anybody uses include/config.h.default, include/mk/config.mk.default,
include/mk/features.mk.default. Is it their purpose for people who, for some
reason can't run ./configure? (I wonder who'd need it) Can we just drop them?

include/config.h.default is out of sync with include/config.h.in;
include/mk/config.mk.default and include/mk/features.mk.default are synced.

Kind regards,
Petr
