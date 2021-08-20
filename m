From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 20 Aug 2021 14:44:31 +0200
Subject: [LTP] [PATCH v4 3/4] syscalls/msgstress03: fix fork failure on
 small memory systems
In-Reply-To: <79cc6f86-1317-9044-147e-8c1bfa2efdd6@canonical.com>
References: <20210629121047.100391-1-krzysztof.kozlowski@canonical.com>
 <20210629121047.100391-4-krzysztof.kozlowski@canonical.com>
 <YR5/qcQyAiFjmVR0@yuki> <YR6AlmzBA35qo81r@yuki>
 <79cc6f86-1317-9044-147e-8c1bfa2efdd6@canonical.com>
Message-ID: <YR+jr+cRL00GJz2h@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > And we do have a patchset that converts msgstress* to new library as
> > well which merges msgstress03 and msgstress01. I will try to have a look
> > into that as well.
> > 
> > http://patchwork.ozlabs.org/project/ltp/list/?series=233661
> 
> The question then would be who should rebase on whose work :)

Given that the patchset is not ready, I will push your fixes first.

-- 
Cyril Hrubis
chrubis@suse.cz
