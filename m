From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 15 Nov 2017 17:47:19 +0300
Subject: [LTP] Failling_Zram01&Zram02_LTP_testsuite
In-Reply-To: <079ad8f2-940f-ea8e-db47-31df346a90af@oracle.com>
References: <CAPiF6TiCjTVGNYH9EDkMFuVKvM-=qscQ0J4d-S8mfxi1-iA8Nw@mail.gmail.com>
 <079ad8f2-940f-ea8e-db47-31df346a90af@oracle.com>
Message-ID: <7518ffca-3552-9aa8-3d4c-4c4c26d91e46@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/15/2017 05:19 PM, Alexey Kodanev wrote:
> ...
> Could you try changing it to the following command that keeps
> the test-case:
>
> dd if=/dev/zero count=1 bs=4KB >> zram${i}/file 2>/dev/null || break

corrected 'bs' parameter:

dd if=/dev/zero count=1 bs=1024 >> zram${i}/file 2>/dev/null || break

Thanks,
Alexey

