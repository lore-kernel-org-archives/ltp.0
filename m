From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 6 May 2021 09:19:29 +0200
Subject: [LTP] LTP Release
Message-ID: <YJOYgZNL7/qp5YCN@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
It's about time for another LTP release. So as usuall let's start with
the list of patches that should go in before the release.

First of all I will have to fix the docparser JSON string escape patch,
I will do so ASAP.

Also I would like to get the CGroup API rewrite in, since that fixes
real problems and is, as far as I can tell, ready to go.

The rtnetlink patchset from Martin is nearly ready as well. I would
apply it as well if we manage to get to final version soon enough.

That is all for me, if there is anything else please reply ASAP.

-- 
Cyril Hrubis
chrubis@suse.cz
