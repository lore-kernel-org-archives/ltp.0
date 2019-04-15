From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 15 Apr 2019 15:53:46 +0200
Subject: [LTP] [PATCH 1/1] configure.ac: Sort alphabetically custom
 autotools functions
In-Reply-To: <20190415125629.GA1958@rei.lan>
References: <20190412145458.4790-1-pvorel@suse.cz>
 <20190415125629.GA1958@rei.lan>
Message-ID: <20190415135346.GB8796@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > tired by the need to manually resolve conflicts when rebase branches
> > which added custom autotools functions (we all add them to the end).

> I guess that this would make the collisions less likely and also make
> it easier to find things, acked.
Thanks, merged.

> On the other hand I would bet that you would have to amend the commits
> anyway because people will forget to insert these at the right place...
This may happen. Or some time later we'll need to sort it again.

Kind regards,
Petr
