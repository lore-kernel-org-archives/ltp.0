From: Li Wang <liwang@redhat.com>
Date: Thu, 15 Oct 2015 11:06:03 +0800
Subject: [LTP] Fwd: [PATCH v3] mem/hugetlb: shift an empty region to use
 in hugemmap02.c
In-Reply-To: <20151014115316.GA1011@rei.suse.cz>
References: <1444745490-9044-1-git-send-email-liwang@redhat.com>
 <20151013164030.GB27888@rei>
 <CAEemH2dRZ11NJSrpNPvR-xA_C_ULsqdObWVFSGBZi-22fRGOcw@mail.gmail.com>
 <CAEemH2d-zx8X7uhCsGAOQYZGADGA36tfytekeYsjU+=ydzXAmQ@mail.gmail.com>
 <20151014115316.GA1011@rei.suse.cz>
Message-ID: <CAEemH2dOaSm_z6XrxOySF_2GCcvovyOQZsf7qNTH16hRADQPGw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Wed, Oct 14, 2015 at 7:53 PM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > hmm, check the return value here is not good, that would make confused in
> > range_is_mapped() used. I'd like to handle the situation by the function
> > itself.
>
> Then we are back at passing the cleanup callback to the function so that
> we can pass it to the tst_brkm(). Otherwise the nr_hugepages that has
> been changed in the test setup() wouldn't be restored.
>
>
Sure, I got your point, the function should be like:

int range_is_mapped(void (*cleanup_fn) (void), unsigned long low, unsigned
long high)
{
   ...
}



-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151015/484ac792/attachment.html>
