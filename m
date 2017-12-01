From: Li Wang <liwang@redhat.com>
Date: Fri, 1 Dec 2017 11:05:05 +0800
Subject: [LTP] [PATCH] hugetlb: fix warnings in cleanup()
In-Reply-To: <20171130145027.GG2924@rei>
References: <20171027085632.18245-1-liwang@redhat.com>
 <20171130145027.GG2924@rei>
Message-ID: <CAEemH2diKYJtxST2bsW7fKeDPshG-X-kUXB+iKW_kOCrc_Nvwg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Nov 30, 2017 at 10:50 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
> The fix is OK, but we may as well do it better, if we move completly the
> logic to the library we do not have to repeat the code in each test.
>
> So what about adding two functions save_nr_hugepages() and
> restore_nr_hugepages() to the library and call these from the test setup
> and cleanup?

Agree! Thanks a lot.



-- 
Li Wang
liwang@redhat.com
