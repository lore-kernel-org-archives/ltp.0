From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 2 Jul 2020 09:36:47 -0400 (EDT)
Subject: [LTP] [PATCH v3 2/2] Add test for CVE 2017-1000405
In-Reply-To: <20200702100151.11780-2-mdoucha@suse.cz>
References: <20200702100151.11780-1-mdoucha@suse.cz>
 <20200702100151.11780-2-mdoucha@suse.cz>
Message-ID: <2038032878.605275.1593697007714.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Fixes #316
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
> 
> Changes since v1:
> - include lapi/mmap.h
> - TCONF if madvise(MADV_HUGEPAGE) fails with EINVAL

Acked-by: Jan Stancek <jstancek@redhat.com>

