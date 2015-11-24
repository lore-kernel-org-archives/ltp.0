From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Nov 2015 17:26:17 +0100
Subject: [LTP] [PATCH v5] commands/mkswap: Added new testcase to test
	mkswap(8).
In-Reply-To: <1447999468-30044-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <564EB14C.7090906@cn.fujitsu.com>
 <1447999468-30044-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20151124162617.GA9183@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +mkswap_test "-L" "testswap" "-L testswap"

I've changed the label to "ltp_testswap" to be extra sure that it does
not collide with anything on the system and pushed the patch, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
