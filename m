From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 22 Jun 2017 11:27:29 +0200
Subject: [LTP] [PATCH v4] controllers/memcg_test_3: Add new regression
	test
In-Reply-To: <1497420761-27575-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <5940D369.3040203@cn.fujitsu.com>
 <1497420761-27575-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170622092728.GA2064@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've changed the setup to produce TCONF if mount returns with ENOENT
(which means that cgroup support is not compiled in kenrnel) and pushed,
thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
