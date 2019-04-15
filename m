From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 15 Apr 2019 14:56:30 +0200
Subject: [LTP] [PATCH 1/1] configure.ac: Sort alphabetically custom
 autotools functions
In-Reply-To: <20190412145458.4790-1-pvorel@suse.cz>
References: <20190412145458.4790-1-pvorel@suse.cz>
Message-ID: <20190415125629.GA1958@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> tired by the need to manually resolve conflicts when rebase branches
> which added custom autotools functions (we all add them to the end).

I guess that this would make the collisions less likely and also make
it easier to find things, acked.

On the other hand I would bet that you would have to amend the commits
anyway because people will forget to insert these at the right place...

-- 
Cyril Hrubis
chrubis@suse.cz
