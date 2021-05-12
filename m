From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 12 May 2021 09:35:41 +0200
Subject: [LTP] [RFC PATCH v2 1/1] netns_netlink: Rewrite into new API
In-Reply-To: <YJp7LBc0IxKuwNh2@pevik>
References: <20210401141210.9536-1-pvorel@suse.cz> <YJpF5mq0oftICi+u@yuki>
 <YJp7LBc0IxKuwNh2@pevik>
Message-ID: <YJuFTZj5h9V02axd@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> BTW I guess sooner or later we should introduce variable to print only info that
> config file is not available (for these embedded platforms and old android).

But that would mean that tests would fail when something is missing. It
makes much more sense to just copy the file somewhere and set
KCONFIG_PATH even if you have to craft that file by hand in order to
enable tests.

-- 
Cyril Hrubis
chrubis@suse.cz
