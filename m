From: Li Wang <liwang@redhat.com>
Date: Wed, 24 Jul 2019 17:33:57 +0800
Subject: [LTP] [PATCH RFC] move_pages12: handle errno EBUSY for
 madvise(..., MADV_SOFT_OFFLINE)
In-Reply-To: <CAEemH2ffEk0QT_LHdo6NEuy2FRkwe4j1rRgf9C0E8HzQE-V_eA@mail.gmail.com>
References: <20190607095213.13372-1-liwang@redhat.com>
 <20190703131005.GA1712@rei>
 <CAEemH2fGUABOfz=Yq6xONgmHwjaiU6n_q=9EXyZz2EUedpuK8Q@mail.gmail.com>
 <CAEemH2eMA78=5eNwJnZPJ1kw1GZnimSyBsQ+e_wrAu3E+JOoPg@mail.gmail.com>
 <20190710125954.GA5628@rei.lan>
 <CAEemH2ffEk0QT_LHdo6NEuy2FRkwe4j1rRgf9C0E8HzQE-V_eA@mail.gmail.com>
Message-ID: <CAEemH2eYgUn9LFr2OzX8TsuZ_jDrbOccU56h8FkSYYztB_Y8yA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Would you mind if I apply this patch? or do you have other thoughts
besides retry mmap on ENOMEM?

-- 
Regards,
Li Wang
