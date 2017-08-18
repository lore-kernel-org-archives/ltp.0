From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 18 Aug 2017 17:05:47 +0200
Subject: [LTP] [PATCH v3] Test for CVE-2016-7042 in /proc/keys show
 function
In-Reply-To: <20170803052927.27129-1-fenggw-fnst@cn.fujitsu.com>
References: <20170726032139.23081-1-fenggw-fnst@cn.fujitsu.com>
 <20170803052927.27129-1-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170818150547.GA27260@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've changed the test to make use of lapi/keyctl.h and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
