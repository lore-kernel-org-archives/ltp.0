From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 21 Feb 2019 19:36:34 +0300
Subject: [LTP] [PATCH 4/4] network: add new test-cases with randomized
 message length
In-Reply-To: <20190220082854.GD15392@x230>
References: <1550587673-7995-1-git-send-email-alexey.kodanev@oracle.com>
 <1550587673-7995-5-git-send-email-alexey.kodanev@oracle.com>
 <20190220082854.GD15392@x230>
Message-ID: <bf0b7f0e-e829-f5d0-14b1-09421d6007cb@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 20.02.2019 11:28, Petr Vorel wrote:
> Hi Alexey,
> 
>> * Change test-cases in dctcp01 (TCP). Default size changed to random size.
> 
>> * New test-cases added to tcp, sctp and udp IPsec tests
> 
>> * Updated bind_noport01
> 
>> * New tests: gre02, geneve02, macsec03, vxlan04
> Commit is quite big. I know, that all is related to randomized message length.
> But maybe these new tests can be added in separate commit.

Thanks for review Petr! Applied with the below corrections as you suggested:

* moved new tests to another commit,
* added one more commit with the fixes for geneve01 and vxlan03.
