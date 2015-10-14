From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 14 Oct 2015 13:53:16 +0200
Subject: [LTP] Fwd: [PATCH v3] mem/hugetlb: shift an empty region to use
 in hugemmap02.c
In-Reply-To: <CAEemH2d-zx8X7uhCsGAOQYZGADGA36tfytekeYsjU+=ydzXAmQ@mail.gmail.com>
References: <1444745490-9044-1-git-send-email-liwang@redhat.com>
 <20151013164030.GB27888@rei>
 <CAEemH2dRZ11NJSrpNPvR-xA_C_ULsqdObWVFSGBZi-22fRGOcw@mail.gmail.com>
 <CAEemH2d-zx8X7uhCsGAOQYZGADGA36tfytekeYsjU+=ydzXAmQ@mail.gmail.com>
Message-ID: <20151014115316.GA1011@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> hmm, check the return value here is not good, that would make confused in
> range_is_mapped() used. I'd like to handle the situation by the function
> itself.

Then we are back at passing the cleanup callback to the function so that
we can pass it to the tst_brkm(). Otherwise the nr_hugepages that has
been changed in the test setup() wouldn't be restored.

-- 
Cyril Hrubis
chrubis@suse.cz
