From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 31 Aug 2021 11:11:21 +0200
Subject: [LTP] [PATCH 1/1] utils: Remove kernbench-0.42
In-Reply-To: <20210831090837.30245-1-pvorel@suse.cz>
References: <20210831090837.30245-1-pvorel@suse.cz>
Message-ID: <YS3yOSp5U0OS+CVd@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Unlike other scripts you proposed to remove this one is used by the
power_management test as a workload. Just do 'git grep kernbench'

-- 
Cyril Hrubis
chrubis@suse.cz
