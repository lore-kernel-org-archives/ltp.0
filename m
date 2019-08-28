From: Li Wang <liwang@redhat.com>
Date: Wed, 28 Aug 2019 18:43:16 +0800
Subject: [LTP] [PATCH v3 1/2] capability: Introduce capability API
In-Reply-To: <20190823094621.21747-1-rpalethorpe@suse.com>
References: <20190823094621.21747-1-rpalethorpe@suse.com>
Message-ID: <CAEemH2dVf66_sKT4iBSEOXg+yFhpL7mAp4Uar5OT6vmbiMa0ZQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> The capability will be dropped in between 'setup' and 'run'.

I'm not sure to put this cap function behind 'setup' is a better choice.

Although it provides more capability in different test phase and makes
test flexible, that also involves more complexity for LTP users,
sometimes test needs to spawn children in the 'setup' and do more
testing in next 'run' phase, which obviously makes us have to consider
more in this case writing.

Anyway, the patchset looks good. We can do some improvements in real
situations then.

    Acked-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
