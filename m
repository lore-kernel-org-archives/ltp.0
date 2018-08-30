From: Jaggi, Manish <Manish.Jaggi@cavium.com>
Date: Thu, 30 Aug 2018 11:34:56 +0000
Subject: [LTP] [Query] With THP  numa01 - test5() fails
Message-ID: <7B4A451B-BE27-4659-A205-E9B5010678A8@caviumnetworks.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi All,

While running LTP test suite with 4.18 kernel ( arm64 ).
I see the below failure with THP (Transparent Hugepages) enabled.
test5 -  Verification of shared memory interleaved on all nodes

numa01 1 TINFO: The system contains 2 nodes: 0 1 
numa01 1 TPASS: NUMA local node and memory affinity
numa01 2 TPASS: NUMA preferred node policy
numa01 3 TPASS: NUMA share memory allocated in preferred node
numa01 4 TPASS: NUMA interleave policy
numa01 5 TFAIL: NUMA interleave share memory allocated in node1 is less than expected

But test3 (# Verification of share memory allocated on preferred node) passes.

Disabling THP makes test5 pass.

Is there something in this particular test that doesnt work well with THP?

-Thanks
Manish

