From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Aug 2021 18:02:30 +0200
Subject: [LTP] [PATCH v4 3/4] syscalls/msgstress03: fix fork failure on
 small memory systems
In-Reply-To: <YR5/qcQyAiFjmVR0@yuki>
References: <20210629121047.100391-1-krzysztof.kozlowski@canonical.com>
 <20210629121047.100391-4-krzysztof.kozlowski@canonical.com>
 <YR5/qcQyAiFjmVR0@yuki>
Message-ID: <YR6AlmzBA35qo81r@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
And we do have a patchset that converts msgstress* to new library as
well which merges msgstress03 and msgstress01. I will try to have a look
into that as well.

http://patchwork.ozlabs.org/project/ltp/list/?series=233661

-- 
Cyril Hrubis
chrubis@suse.cz
