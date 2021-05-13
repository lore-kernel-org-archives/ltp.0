From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 13 May 2021 13:02:19 +0200
Subject: [LTP] [Automated-testing] LTP pre-release git freeze and call
 for testing
In-Reply-To: <YJz4A3mR3jHciihe@yuki>
References: <YJOYgZNL7/qp5YCN@yuki> <YJpq26w8NBvBzUSc@yuki>
 <YJz4A3mR3jHciihe@yuki>
Message-ID: <YJ0HO1xaM2x+o9cW@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> As previously planned LTP git is now frozen for anything but imporatnt
> fixes and the (ideally) week of pre-release testing starts now.
As release fixes, I'd like to merge these netlink detection support fixes for
old kernels and fix and tonight send also add lapi/if_addr.h with IFA_FLAGS
(to fix compilation on some old kernels).

Last thing which I'd like is to state which version we support in this release
(as document to doc/ and wiki). After release we can discuss which support we
can drop.

Kind regards,
Petr

> If you haven't tested latest LTP git please do so now.
