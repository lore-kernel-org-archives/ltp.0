From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 22 Jun 2017 17:43:50 +0800
Subject: [LTP] [PATCH v4] controllers/memcg_test_3: Add new regression
	test
In-Reply-To: <20170622092728.GA2064@rei.suse.de>
References: <5940D369.3040203@cn.fujitsu.com>
 <1497420761-27575-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20170622092728.GA2064@rei.suse.de>
Message-ID: <594B9156.1000200@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On 06/22/2017 05:27 PM, Cyril Hrubis wrote:
> Hi!
> I've changed the setup to produce TCONF if mount returns with ENOENT
> (which means that cgroup support is not compiled in kenrnel) and pushed,

Ah, I forgot this!
Thanks very much for the review!

Best Regards,
Guangwen Feng

> thanks.
> 


