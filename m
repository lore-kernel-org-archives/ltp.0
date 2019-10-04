From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 4 Oct 2019 19:05:20 +0200
Subject: [LTP] [RFC PATCH 2/2] doc: Add user-guide.txt
In-Reply-To: <20191004132129.GE5442@rei.lan>
References: <20190930115852.21672-1-pvorel@suse.cz>
 <20190930115852.21672-3-pvorel@suse.cz> <20191003114428.GC1858@rei>
 <20191003164347.GA2061@dell5510> <20191004132129.GE5442@rei.lan>
Message-ID: <20191004170520.GA24112@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

...
> > Yep, I'm aware ffsb is needed from $LTPROOT/bin. I haven't forced to send
> > proposal about ffbs adding into separate repository, that why I included it.
> > But sure, I'll drop this part.
> > Ack the rest?

> Yes, the rest is fine.

Thanks, merged, with simple change:

-For more info see `doc/user-guide.txt`.
+For more info see `doc/user-guide.txt` or online at
+https://github.com/linux-test-project/ltp/wiki/User-Guidelines.

(I created that page in wiki).

Kind regards,
Petr
