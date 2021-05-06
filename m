From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 6 May 2021 10:10:36 +0200
Subject: [LTP] LTP Release
In-Reply-To: <YJOYgZNL7/qp5YCN@yuki>
References: <YJOYgZNL7/qp5YCN@yuki>
Message-ID: <YJOkfJIzPqOXEvu+@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> It's about time for another LTP release. So as usuall let's start with
> the list of patches that should go in before the release.

> First of all I will have to fix the docparser JSON string escape patch,
> I will do so ASAP.
+1

> Also I would like to get the CGroup API rewrite in, since that fixes
> real problems and is, as far as I can tell, ready to go.
+1

> The rtnetlink patchset from Martin is nearly ready as well. I would
> apply it as well if we manage to get to final version soon enough.
+1

> That is all for me, if there is anything else please reply ASAP.
netns_netlink fix + rewrite [1] would be nice to get in.
BTW I plan to add check for ip version, but as part of general approach
proposal (not yet finished), thus after release.

And only if you have time: docparse generation improvements [2].

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20210401141210.9536-1-pvorel@suse.cz/
[2] https://patchwork.ozlabs.org/project/ltp/list/?series=242088
