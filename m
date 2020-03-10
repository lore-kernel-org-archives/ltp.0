From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 10 Mar 2020 03:58:48 -0400 (EDT)
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_PANICKED=3A_Test_report_for_kernel_5?=
 =?utf-8?q?=2E5=2E8-c30f33b=2Ecki_=28stable-queue=29?=
In-Reply-To: <CAFqZXNugDTJ8MQePK1Cyz2TOJiPcPrq3ohmNZngJjaTCq1Y6mQ@mail.gmail.com>
References: <cki.411617A928.D7E40QQCW6@redhat.com>
 <20200309215305.GV21491@sasha-vm>
 <CAFqZXNugDTJ8MQePK1Cyz2TOJiPcPrq3ohmNZngJjaTCq1Y6mQ@mail.gmail.com>
Message-ID: <1743314452.221557.1583827128244.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> > Following the link above I got to
> > https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/03/09/480158/audit__audit_testsuite_test/,
> > but it shows that all tests are passing? The console log looks fine too:
> > https://cki-artifacts.s3.us-east-2.amazonaws.com/datawarehouse/2020/03/09/480158/x86_64_5_console.log.
> > Where's the panic?
> 
> The panic happened during the LTP test on s390x (note the lightning
> symbols under s390x, Host 1). The backtrace is at the end of
> https://cki-artifacts.s3.us-east-2.amazonaws.com/datawarehouse/2020/03/09/480158/s390x_1_console.log

Which looks like same panic reported for last couple days. See:
  https://lore.kernel.org/stable/976629603.10711789.1583698043547.JavaMail.zimbra@redhat.com/
  https://lore.kernel.org/lkml/20200224030007.3990-1-cai@lca.pw/

