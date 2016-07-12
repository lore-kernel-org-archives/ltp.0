From: Li Wang <liwang@redhat.com>
Date: Tue, 12 Jul 2016 17:22:37 +0800
Subject: [LTP] [PATCH] swapping: replace mem_free by mem_available
In-Reply-To: <1468302679-29651-1-git-send-email-liwang@redhat.com>
References: <1468302679-29651-1-git-send-email-liwang@redhat.com>
Message-ID: <CAEemH2ePcGqVajks4x7LRVBoz88kN386XY3Yb3YwdpyGuccyew@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Sorry, there is one more thing I forgot to take care, the
"MemAvailable:" I invovled is not exist in all kernels
(e.g. kernel < 3.14). So this patch is not applicable to
all distributions, such as Fedora 19. :(

$ cat /etc/redhat-release
Fedora release 19 (Schrödinger’s Cat)

$ cat /proc/meminfo
MemTotal:        7654500 kB
MemFree:          507388 kB
Buffers:           87280 kB
Cached:          1145736 kB
...

I will compose a new patch to solve the limitation.


Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160712/9dbe0af0/attachment.html>
