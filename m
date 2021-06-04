From: Enji Cooper <yaneurabeya@gmail.com>
Date: Fri, 4 Jun 2021 11:01:45 -0700
Subject: [LTP] [RFC PATCH 1/3] make: Add make check{,-c,-shell} targets
In-Reply-To: <20210603183827.24339-2-pvorel@suse.cz>
References: <20210603183827.24339-1-pvorel@suse.cz>
 <20210603183827.24339-2-pvorel@suse.cz>
Message-ID: <392BDC1B-F73E-411E-AE03-71DA0CBAB2D8@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> On Jun 3, 2021, at 11:38 AM, Petr Vorel <pvorel@suse.cz> wrote:
> 
> For testing C and shell API.

Why not just add a single ?make check? target that calls the C and shell targets to match what most open source projects do in terms of testing? Also, continuing on in light of errors seems like a good default behavior to have as it would prevent a single error/failure from gathering all other results.

My 2 cents,
-Enji
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210604/1b27c9a2/attachment-0001.sig>
