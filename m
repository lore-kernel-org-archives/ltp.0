From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 27 Mar 2019 17:21:44 +0100
Subject: [LTP] [PATCH 1/1] shell: Fix handling default parameters in
	tst_mkfs()
In-Reply-To: <20190327160316.GA9691@rei.lan>
References: <20190327155252.761-1-pvorel@suse.cz>
 <20190327160316.GA9691@rei.lan>
Message-ID: <20190327162144.GA7852@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> We can do the same thing twice as well, which may be a bit more
> readable:

> 	[ $# -ge 1 ] && shift
> 	[ $# -ge 1 ] && shift
I'd prefer my way, as this looks like entered twice by accident.
But you chose the variant :).

Kind regards,
Petr
