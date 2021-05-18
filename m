From: Li Wang <liwang@redhat.com>
Date: Tue, 18 May 2021 17:23:58 +0800
Subject: [LTP] [RFC PATCH 3/6] API: Add tst_ to file_* functions
In-Reply-To: <20210517163029.22974-4-rpalethorpe@suse.com>
References: <20210517163029.22974-1-rpalethorpe@suse.com>
 <20210517163029.22974-4-rpalethorpe@suse.com>
Message-ID: <CAEemH2e2wdr01dt9zceWSOOmY25fCLsmLfn=Qg7mYMgi3JumCA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, May 18, 2021 at 12:31 AM Richard Palethorpe via ltp
<ltp@lists.linux.it> wrote:
>
> Usually LTP library functions are prepended with tst_ if not with
> safe_.

I'm not very sure if FILE_PRINTF should be added with TST_ prefix, but
it seems no harm to do that.

So I just hold a neutral view on this patch:).

-- 
Regards,
Li Wang

