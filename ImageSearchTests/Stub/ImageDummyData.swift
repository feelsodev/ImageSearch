//
//  ImageDummyData.swift
//  ImageSearchTests
//
//  Created by once on 2021/06/26.
//

import Foundation

@testable import ImageSearch

struct ImageDummyData {
  static let imageJSONString = """
    {
      "documents": [
        {
          "collection": "blog",
          "datetime": "2012-06-28T18:07:00.000+09:00",
          "display_sitename": "네이버블로그",
          "doc_url": "http://blog.naver.com/pjbclub/150141648154",
          "height": 368,
          "image_url": "http://postfiles11.naver.net/20120628_58/pjbclub_1340873310757n6GjG_JPEG/Cat_by_AWhisperOfLove.jpg?type=w3",
          "thumbnail_url": "https://search2.kakaocdn.net/argon/130x130_85_c/1AY7IzepGoV",
          "width": 550
        },
        {
          "collection": "blog",
          "datetime": "2011-10-26T22:12:00.000+09:00",
          "display_sitename": "네이버블로그",
          "doc_url": "http://blog.naver.com/desternity69/20141472792",
          "height": 271,
          "image_url": "http://postfiles4.naver.net/20111026_83/desternity69_1319634611707SU8Gh_JPEG/cat042.jpg?type=w2",
          "thumbnail_url": "https://search1.kakaocdn.net/argon/130x130_85_c/Jm8uB8heZnl",
          "width": 370
        },
        {
          "collection": "blog",
          "datetime": "2019-08-22T14:54:00.000+09:00",
          "display_sitename": "네이버블로그",
          "doc_url": "http://blog.naver.com/yundah/221624795139",
          "height": 966,
          "image_url": "http://postfiles3.naver.net/MjAxOTA4MjJfNjkg/MDAxNTY2NDUzMjgyMzg4.17Nv_yHGFHezLzNrAcfs3Wq178naYoKlC_P-YsgNGk8g.WfwzJA1iD11xFSxs9iUMssF__n9xym_crR787pnqeKcg.JPEG.yundah/cat_(14).jpg?type=w966",
          "thumbnail_url": "https://search3.kakaocdn.net/argon/130x130_85_c/2psFF2Z2MVC",
          "width": 966
        },
        {
          "collection": "cafe",
          "datetime": "2015-11-29T22:42:36.000+09:00",
          "display_sitename": "Daum카페",
          "doc_url": "http://cafe.daum.net/bigscooter/Mr20/54623",
          "height": 640,
          "image_url": "http://cfile272.uf.daum.net/image/2657B742565A8955186678",
          "thumbnail_url": "https://search4.kakaocdn.net/argon/130x130_85_c/6lUrNLfHuWp",
          "width": 640
        },
        {
          "collection": "blog",
          "datetime": "2018-01-26T10:18:00.000+09:00",
          "display_sitename": "네이버블로그",
          "doc_url": "http://blog.naver.com/yundah/221193860304",
          "height": 279,
          "image_url": "http://postfiles16.naver.net/MjAxODAxMjZfMTk3/MDAxNTE2OTI5NDI0NTgw.XN1CF_5ho7bSmBeJ36C6yXAX74BXG4PkmvQLBo-VLzsg.RIWRby-Burd1E2JmMMLki4BpgiygjDiAa3Pzno3Cpa4g.JPEG.yundah/cat_%287%29.jpg?type=w966",
          "thumbnail_url": "https://search2.kakaocdn.net/argon/130x130_85_c/EB9Tg66rbDv",
          "width": 420
        }
      ],
      "meta": {
        "is_end": false,
        "pageable_count": 3995,
        "total_count": 1354713
      }
    }
    """
  
  static let imageArry: [Image] = [
    Image(datetime: "2012-06-28T18:07:00.000+09:00",
          displaySitename: "네이버블로그",
          imageURL: "http://postfiles11.naver.net/20120628_58/pjbclub_1340873310757n6GjG_JPEG/Cat_by_AWhisperOfLove.jpg?type=w3",
          thumbnailURL: "https://search2.kakaocdn.net/argon/130x130_85_c/1AY7IzepGoV",
          height: 368, width: 550),
    Image(datetime: "2011-10-26T22:12:00.000+09:00",
          displaySitename: "네이버블로그",
          imageURL: "http://postfiles4.naver.net/20111026_83/desternity69_1319634611707SU8Gh_JPEG/cat042.jpg?type=w2",
          thumbnailURL: "https://search1.kakaocdn.net/argon/130x130_85_c/Jm8uB8heZnl",
          height: 271, width: 370),
    Image(datetime: "2019-08-22T14:54:00.000+09:00",
          displaySitename: "네이버블로그",
          imageURL: "http://postfiles3.naver.net/MjAxOTA4MjJfNjkg/MDAxNTY2NDUzMjgyMzg4.17Nv_yHGFHezLzNrAcfs3Wq178naYoKlC_P-YsgNGk8g.WfwzJA1iD11xFSxs9iUMssF__n9xym_crR787pnqeKcg.JPEG.yundah/cat_(14).jpg?type=w966",
          thumbnailURL: "https://search3.kakaocdn.net/argon/130x130_85_c/2psFF2Z2MVC",
          height: 966, width: 966),
    Image(datetime: "2015-11-29T22:42:36.000+09:00",
          displaySitename: "Daum카페",
          imageURL: "http://cfile272.uf.daum.net/image/2657B742565A8955186678",
          thumbnailURL: "https://search4.kakaocdn.net/argon/130x130_85_c/6lUrNLfHuWp",
          height: 640, width: 640),
    Image(datetime: "2018-01-26T10:18:00.000+09:00",
          displaySitename: "네이버블로그",
          imageURL: "http://postfiles16.naver.net/MjAxODAxMjZfMTk3/MDAxNTE2OTI5NDI0NTgw.XN1CF_5ho7bSmBeJ36C6yXAX74BXG4PkmvQLBo-VLzsg.RIWRby-Burd1E2JmMMLki4BpgiygjDiAa3Pzno3Cpa4g.JPEG.yundah/cat_%287%29.jpg?type=w966",
          thumbnailURL: "https://search2.kakaocdn.net/argon/130x130_85_c/EB9Tg66rbDv",
          height: 279, width: 420)
  ]
}
