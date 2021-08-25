From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Aug 2021 16:07:29 +0200
Subject: [LTP] [PATCH 4/7] syscalls/clone04: Convert to new API
In-Reply-To: <20210813072647.21802-1-zhanglianjie@uniontech.com>
References: <20210813072647.21802-1-zhanglianjie@uniontech.com>
Message-ID: <YSZOoXcxQAlqWuiw@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor change to the documentation comment and message.

Also if you look at man 2 clone there are plenty of checks that we are
missing here, we can at least easily add all the check for invalid flags
combinations, unaligned stack and possibly a few more.

-- 
Cyril Hrubis
chrubis@suse.cz
