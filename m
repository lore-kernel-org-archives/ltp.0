From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 15 May 2017 09:15:36 -0400 (EDT)
Subject: [LTP] [PATCH v2] [RFC] pselect01: Tune thresholds
In-Reply-To: <59198103.4070308@cn.fujitsu.com>
References: <20170512141658.26810-1-chrubis@suse.cz>
 <495691788.11461692.1494842630946.JavaMail.zimbra@redhat.com>
 <59198103.4070308@cn.fujitsu.com>
Message-ID: <623640767.11529328.1494854136525.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi Jan and Cyril,
> 
> Did you get the following error message when running pselect01 on
> RHEL5.11GA (physical machine):
> =====================================================================================
> [root@RHEL5U11ga_Intel64 pselect]# ./pselect01
> tst_test.c:847: INFO: Timeout per run is 0h 05m 00s
> pselect01.c:62: INFO: pselect() sleeping for 1 secs 0 nsec 1 iterations
> pselect01.c:95: PASS: pselect() slept for 1000443us, requested
> 1000000us, treshold 10200
> pselect01.c:62: INFO: pselect() sleeping for 0 secs 1000000 nsec 100
> iterations
> pselect01.c:95: PASS: pselect() slept for 101455us, requested 100000us,
> treshold 21000
> pselect01.c:62: INFO: pselect() sleeping for 0 secs 2000000 nsec 100
> iterations
> pselect01.c:95: PASS: pselect() slept for 203069us, requested 200000us,
> treshold 22000
> pselect01.c:62: INFO: pselect() sleeping for 0 secs 10000000 nsec 10
> iterations
> pselect01.c:83: FAIL: pselect() woken up too early 99536us, expected
> 100000us
> pselect01.c:62: INFO: pselect() sleeping for 0 secs 100000000 nsec 1
> iterations
> pselect01.c:95: PASS: pselect() slept for 100559us, requested 100000us,
> treshold 1200
> =====================================================================================
> 
> It seems that pselect woke up early on RHEL5.11GA.

Yes, I see that too. It fails pretty often, even on KVM guest.

pselect6(0, [], NULL, NULL, {0, 2000000}, {NULL, 8}) = 0 (Timeout) <0.001822>
pselect6(0, [], NULL, NULL, {0, 10000000}, {NULL, 8}) = 0 (Timeout) <0.009775>
pselect6(0, [], NULL, NULL, {0, 100000000}, {NULL, 8}) = 0 (Timeout) <0.099808>

